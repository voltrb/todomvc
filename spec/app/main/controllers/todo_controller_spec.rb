require 'spec_helper'

describe Main::TodoController do
  before do
    @todos_controller = Main::TodoController.new(volt_app)
  end
end