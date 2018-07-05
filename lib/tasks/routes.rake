# これをruby/2.1.0/gems/railties-4.1.0/lib/rails/tasks/routes.rake あたりに入れればいいそう
# User.....Ruby23-x64\lib\ruby\gems\2.3.0\gems\railties-5.2.0\lib\rails\tasks
# APIのルーティングを表示する
desc "Routes with API routes"
task all_routes: :environment do
  Rails.application.require_environment!

  require 'action_dispatch/routing/inspector'
  all_routes = Rails.application.routes.routes
  inspector = ActionDispatch::Routing::RoutesInspector.new(all_routes)
  output = inspector.format(ActionDispatch::Routing::ConsoleFormatter.new, ENV['CONTROLLER'])
  puts output

  first_line = output.lines.first
  verb_index = first_line.index("Verb")
  pattern_index = first_line.index("URI Pattern")

  API.routes.each do |api|
    method = api.route_method
                 .ljust(pattern_index-verb_index-1) # "GET"     => "GET    "
                 .rjust(pattern_index-1)            # "GET    " => "                GET    "

    path = api.route_path
    puts "#{method} #{path}"
  end
end