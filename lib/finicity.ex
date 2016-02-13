defmodule Finicity do
  use HTTPotion.Base

  def partner_authentication([partner_id: partner_id, partner_secret: partner_secret]) do
    data = {:credentials, nil, [
               {:partnerId, nil, partner_id},
               {:partnerSecret, nil, partner_secret}]}
    |> XmlBuilder.generate
    %{status_code: 200, body: body} = post("/v2/partners/authentication", [body: data, timeout: 20000])
    body |> Floki.Finder.find("token") |> Floki.FlatText.get
  end

  def get_institutions(token, params) do
    %{status_code: 200, body: body} = get("/v1/institutions?" <> URI.encode_query(params), [headers: app_token(token)])
    body |> Floki.Finder.find("institutions")
  end

  defp process_url(url) do
    "https://api.finicity.com/aggregation" <> url
  end

  defp process_request_headers(headers) do
    headers
    |> Dict.put(:"Content-Type", "application/xml")
    |> Dict.put(:"Finicity-App-Key", app_key())
  end

  defp process_response_body(body) do
    body |> Floki.parse
  end

  defp app_token(token) do
    ["Finicity-App-Token": token]
  end

  defp app_key do
    System.get_env("FINICITY_APP_KEY") || Application.get_env(:finicity, :app_key)
  end

  defp partner_id do
    System.get_env("FINICITY_PARTNER_ID") || Application.get_env(:finicity, :partner_id)
  end

  defp partner_secret do
    System.get_env("FINICITY_PARTNER_SECRET") || Application.get_env(:finicity, :partner_secret)
  end
end
