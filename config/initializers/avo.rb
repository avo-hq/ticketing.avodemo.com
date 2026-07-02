# For more information regarding these settings check out our docs https://docs.avohq.io
# The values disaplayed here are the default ones. Uncomment and change them to fit your needs.
Avo.configure do |config|
  ## == Routing ==
  config.root_path = '/admin'
  # used only when you have custom `map` configuration in your config.ru
  # config.prefix_path = "/internal"

  # Sometimes you migth want to mount Avo's engines yourself.
  # https://docs.avohq.io/3.0/routing.html
  # config.mount_avo_engines = true

  # Where should the user be redirected when visting the `/avo` url
  config.home_path = "#{config.root_path}/resources/tickets"

  ## == Licensing ==
  config.license_key = ENV['AVO_LICENSE_KEY']
  config.exclude_from_status = ["license_key"]

  ## == Set the context ==
  config.set_context do
    # Return a context object that gets evaluated in Avo::ApplicationController
  end

  ## == Authentication ==
  config.current_user_method = :current_user
  # config.authenticate_with do
  # end

  ## == Authorization ==
  # config.authorization_methods = {
  #   index: 'index?',
  #   show: 'show?',
  #   edit: 'edit?',
  #   new: 'new?',
  #   update: 'update?',
  #   create: 'create?',
  #   destroy: 'destroy?',
  #   search: 'search?',
  # }
  # config.raise_error_on_missing_policy = false
  # config.authorization_client = :pundit

  ## == Localization ==
  # config.locale = 'en-US'

  ## == Resource options ==
  # config.resource_controls_placement = :right
  # config.model_resource_mapping = {}
  # config.default_view_type = :table
  # config.per_page = 24
  # config.per_page_steps = [12, 24, 48, 72]
  # config.via_per_page = 8
  # config.id_links_to_resource = false
  # config.cache_resources_on_index_view = true
  ## permanent enable or disable cache_resource_filters, default value is false
  # config.cache_resource_filters = false
  ## provide a lambda to enable or disable cache_resource_filters per user/resource.
  # config.cache_resource_filters = -> { current_user.cache_resource_filters? }

  ## == Customization ==
  config.tailwindcss_integration_enabled = true
  # config.timezone = 'UTC'
  # config.currency = 'USD'
  # config.hide_layout_when_printing = false
  # config.full_width_container = false
  # config.full_width_index_view = false
  # config.search_debounce = 300
  # config.view_component_path = "app/components"
  # config.display_license_request_timeout_error = true
  # config.disabled_features = []
  # config.buttons_on_form_footers = true
  # config.field_wrapper_layout = true
  # config.resource_parent_controller = "Avo::ResourcesController"

  ## == Branding ==
  config.appearance = {
    logo: "/img/logo.png",
    logomark: "/img/logo.png",
  }

  ## == Breadcrumbs ==
  # config.display_breadcrumbs = true
  # config.set_initial_breadcrumbs do
  #   add_breadcrumb "Home", '/avo'
  # end

  ## == Menus ==
  config.main_menu = -> {
    section "Manage", icon: "tabler/outline/clipboard-check" do
      resource :ticket, icon: "tabler/outline/ticket"
    end

    section "HR", icon: "tabler/outline/user-circle" do
      resource :user, icon: "tabler/outline/user"
    end

    section "Configurations", icon: "tabler/outline/settings" do
      tool :settings
    end
  }
  # config.profile_menu = -> {
  #   link "Profile", path: "/avo/profile", icon: "user-circle"
  # }


  def tool(name = nil)
    link(name.to_s.humanize, path: root_path(paths: [name]))
  end
end
