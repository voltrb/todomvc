require 'spec_helper'

describe Todo do
  it 'should strip whitespace on label' do
    todo = Todo.new(label: '  do something  ')
    expect(todo.label).to eq('do something')
  end

  it 'should mark editing to false when stopping editing' do
    todo = Todo.new
    todo.editing = true

    allow(todo).to receive(:destroy)
    todo.stop_editing

    expect(todo.editing).to eq(false)
  end

  it 'should not destroy a model with a label when stopping editing' do
    todo = Todo.new(label: 'label 1')

    expect(todo).to_not receive(:destroy)

    todo.stop_editing
  end

  it 'should destroy a model with a label when stopping editing' do
    todo = Todo.new(label: 'label 1')

    expect(todo).to receive(:destroy)

    todo.label = ''

    todo.stop_editing
  end
end
