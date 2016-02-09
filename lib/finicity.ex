defmodule Finicity do
  use HTTPotion.Base

  def process_url(url) do
    "https://api.finicity.com/aggregation" <> url
  end

  def process_request_headers(headers) do
    headers
    |> Dict.put(:"Content-Type", "application/xml")
    |> Dict.put(:"Finicity-App-Key", app_key())
  end

  def process_response_body(body) do
    body |> Floki.parse
  end

  def app_token(token) do
    ["Finicity-App-Token": token]
  end

  def app_key do
    System.get_env("FINICITY_APP_KEY")
  end

  def partner_id do
    System.get_env("FINICITY_PARTNER_ID")
  end

  def partner_secret do
    System.get_env("FINICITY_PARTNER_SECRET")
  end

  def partner_authentication do
    data = {:credentials, nil, [
               {:partnerId, nil, partner_id()},
               {:partnerSecret, nil, partner_secret()}]}
    |> XmlBuilder.generate
    %{status_code: 200, body: body} = post("/v2/partners/authentication", [body: data])
    body |> Floki.Finder.find("token") |> Floki.FlatText.get
  end

  def get_institutions([params: params, token: token]) do
    %{status_code: 200, body: body} = get("/v1/institutions?" <> URI.encode_query(params), [headers: app_token(token)])
    body |> Floki.Finder.find("institutions")
  end
end
