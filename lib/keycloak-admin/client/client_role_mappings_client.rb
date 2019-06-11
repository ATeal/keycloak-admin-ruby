module KeycloakAdmin
  class ClientRoleMappingsClient < Client
    def initialize(configuration, user_resource, client_id)
      super(configuration)
      @user_resource = user_resource
      @client_id = client_id
    end

    def list_available
      response = execute_http do
        RestClient::Resource.new(list_available_url, @configuration.rest_client_options).get(headers)
      end
      JSON.parse(response).map { |role_as_hash| RoleRepresentation.from_hash(role_as_hash) }
    end

    def list_available_url
      "#{@user_resource.resource_url}/role-mappings/clients/#{@client_id}/available"
    end
  end
end
