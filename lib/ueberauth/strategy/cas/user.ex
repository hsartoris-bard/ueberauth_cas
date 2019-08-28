import SweetXml

defmodule Ueberauth.Strategy.CAS.User do
  @moduledoc """
  Representation of a CAS user with their roles.
  """

  #defstruct principal: nil, 
  #  employeeType: nil, 
  #  email: nil, 
  #  first_name: nil, 
  #  last_name: nil, 
  #  name: nil,
  #  eduPersonPrincipalName: nil,
  #  nickname: nil
  defstruct [
    user: nil,
    employeeType: nil,
    mail: nil,
    givenName: nil,
    sn: nil,
    cn: nil,
    eduPersonPrincipalName: nil,
    uid: nil
  ]

  defp attr_map do
    %{
      :principal => "cas:user",
      :employeeType => "/cas:employeeType",
      :email => "/cas:mail",
      :first_name => "/cas:givenName",
      :last_name => "/cas:sn",
      :name => "/cas:cn",
      :eduPersonPrincipalName => "/cas:eduPersonPrincipalName",
      :nickname => "/cas:uid"
    }
  end

  alias Ueberauth.Strategy.CAS.User

  def from_xml(body) do
    body |> IO.inspect
    #opts = assign_attrs(%{}, body, Map.keys(attr_map()))
    #opts = %{user: get_attr(body, "cas:user")}
    #opts |> IO.inspect opts
    %User{}
    |> set_attrs(body)
    IO.inspect("Got here")
    #|> struct(assign_attrs(%{}, body, Map.keys(attr_map())))

    #%User{}
    #|> set_name(body)
    #|> set_email(body)
    #|> set_roles(body)
  end

  defp set_attrs(user, body) do
    user
    |> %User{user | user: get_attr(body, "/cas:uid")}
    |> %User{user | employeeType: get_attr(body, "/cas:employeeType")}
    |> %User{user | mail: get_attr(body, "/cas:mail")}
    |> %User{user | givenName: get_attr(body, "/cas:givenName")}
    |> %User{user | sn: get_attr(body, "/cas:sn")}
    |> %User{user | cn: get_attr(body, "/cas:cn")}
    |> %User{user | eduPersonPrincipalName: get_attr(body, "/cas:eduPersonPrincipalName")}

  defp assign_attrs(attrs, _body, []), do: attrs
  defp assign_attrs(attrs, body, [key | tail]) do
    %{^key => value} = body
    %{attrs | key => get_attr(body, value)} 
    |> assign_attrs(body, tail)
  end

  defp get_attr(body, attr), do: body |> xpath(~x"//#{attr}/text()")


    #defp set_name(user, body),   do: %User{user | name: email(body)}
    #defp set_email(user, body),  do: %User{user | email: email(body)}
    #defp set_roles(user, _body), do: %User{user | roles: ["developer", "admin"]}

    #defp email(body) do
    #  Floki.find(body, "cas|user")
    #  |> List.first
    #  |> Tuple.to_list
    #  |> List.last
    #  |> List.first
    #  |> String.downcase
    #end

end
