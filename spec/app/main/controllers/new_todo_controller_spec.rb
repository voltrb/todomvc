require 'spec_helper'

describe Main::NewTodoController do
  before do
    @new_todo_controller = Main::NewTodoController.new(volt_app)
  end

  it 'should change labels and clear on load' do
    @new_todo_controller.new_todo_label = 'sample'
    expect(@new_todo_controller.new_todo_label).to eq('sample')

    @new_todo_controller.index

   expect(@new_todo_controller.new_todo_label).to eq('')
  end

  it 'should create a new todo from the new_todo_label when calling add_todo' do
    @new_todo_controller.new_todo_label = 'first todo'

    @new_todo_controller.add_todo

    expect(store.todos.count.sync).to eq(1)

    todo = store.todos.first.sync

    expect(todo.label).to eq('first todo')

    # should clear the label field
    expect(@new_todo_controller.new_todo_label).to eq('')
  end
end