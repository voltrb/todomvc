# The MainController is responsible for showing the individual Todos and listing
# things like how many are checked.
module Main
  class MainController < Volt::ModelController
    model :store

    # Use the route to filter which todos we're showing
    def filtered_todos
      query = store.todos
      case params._filter
      when 'completed'
        query = query.where(completed: true)
      when 'active'
        query = query.where({'$or' => [{completed: false}, {completed: nil}]})
      end

      query
    end

    def complete
      todos.count(&:completed)
    end

    def incomplete
      Promise.when(todos.size, complete).then do |size, complete|
        size - complete
      end
    end

    # Remove all completed
    def clear_completed
      todos.all.reverse.select(&:completed).each(&:destroy)
    end

    # Binding for if the all complete checkbox should be checked.
    def all_complete
      # incomplete returns a promise, so we check if its zero inside of a .then
      # block.
      incomplete.then { |val| val == 0 }
    end

    # Called when the complete all checkbox is checked, change the state of all
    # todos to val (true or false)
    def all_complete=(val)
      todos.all.each {|todo| todo._completed = val }
    end


    private

    # The main template contains a #template binding that shows another
    # template.  This is the path to that template.  It may change based
    # on the params._component, params._controller, and params._action values.
    def main_path
      "#{params._component || 'main'}/#{params._controller || 'main'}/#{params._action || 'index'}"
    end

    # Determine if the current nav component is the active one by looking
    # at the first part of the url against the href attribute.
    def active_tab?
      url.path.split('/')[1] == attrs.href.split('/')[1]
    end
  end
end