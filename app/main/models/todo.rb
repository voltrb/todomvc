class Todo < Volt::Model
  field :label, String
  field :completed

  # A local reactive variable to store the editing state
  reactive_accessor :editing

  def label=(val)
    # Strip the string
    set(:label, val.strip)
  end

  def stop_editing
    self.editing = false

    # If the edit removed the label, delete the item
    if label.blank?
      destroy
    end
  end
end
