module Main
  class TodoController < Volt::ModelController
    # Edit is called when the user double clicks on the span showing the label.
    # It toggles the edit state and sets up an event listener to cancel editing
    # when the document is clicked on, assuming they are not clicking inside of
    # the edit field.
    def edit(event)
      event.stop!
      model.editing = true

      # We create an anonymous function so we can tell jquery to remove it
      # when we don't need it anymore
      @stop_func = proc do |event|
        # get the li for the view
        li = self.first_element

        # Don't stop if we are inside of the todo item
        if `!$.contains(li, event.target)`
          stop_editing
        end
      end

      # Setup document wide click listener
      `$(document).on('click.editing', self.stop_func)`
    end

    # Stop the editing, remove the document click listener
    def stop_editing
      model.stop_editing
      `$(document).off('click.editing', self.stop_func)`
    end

  end
end
