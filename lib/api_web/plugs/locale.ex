defmodule ApiWeb.Locale do
  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    case conn.params["locale"] do
      nil     -> conn
      locale  ->
        Gettext.put_locale(ApiWeb.Gettext, locale)
        conn
    end
  end
end
