import SweetXml

defmodule Ueberauth.Strategy.CAS.User do
  @moduledoc """
  Representation of a CAS user with their roles.
  """

  defstruct [
    uid: nil,
    employeeType: nil,
    mail: nil,
    givenName: nil,
    sn: nil,
    cn: nil,
    eduPersonPrincipalName: nil,
    udc_identifier: nil
  ]

  alias Ueberauth.Strategy.CAS.User

  def from_xml(body) do
    opts = Enum.map(
      Map.from_struct(User),
      fn ({attr, _}) ->
        {
          attr, 
          body |> xpath(~x"///cas:#{Atom.to_string(attr)}/text()")
        }
      end
    )
    
    %User{} |> struct(opts)
  end
end
