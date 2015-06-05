# The NewTodoController renders the part of the page responsible for showing
# the field where you add the todo.
module Main
  class NewTodoController < Volt::ModelController
    model :store
    reactive_accessor :new_todo_label

    # Called when the view loads
    def index
      self.new_todo_label = ''
    end

    def add_todo
      if new_todo_label.present?
        todos << {label: new_todo_label}
        index # clear the field
      end
    end

  end
end
