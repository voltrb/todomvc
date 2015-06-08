require 'spec_helper'

describe Main::MainController do
  before do
    @main_controller = Main::MainController.new(volt_app)
  end

  describe "with some todos" do
    before do
      store.todos.create({title: 'One', completed: true})
      store.todos.create({title: 'Two', completed: true})
      store.todos.create({title: 'Three', completed: false})
    end

    it 'should count how many completed todos there are' do
      @main_controller.complete.then do |count|
        expect(count).to eq(2)
      end
    end

    it 'should count how many todos are not complete' do
      @main_controller.incomplete.then do |count|
        expect(count).to eq(1)
      end
    end

    it 'should clear complete' do
      store.todos.count.then {|v| expect(v).to eq(3) }

      @main_controller.clear_completed

      store.todos.count.then do |v|
          expect(v).to eq(2)
      end
    end

    it 'should return all todos if no filter' do
      @main_controller.filtered_todos.count.then do |count|
        expect(count).to eq(3)
      end
    end

    it 'should filter based on completed filter param' do
      params._filter = 'completed'

      @main_controller.filtered_todos.count.then do |count|
        expect(count).to eq(2)
      end
    end

    it 'should filter based on active filter' do
      params._filter = 'completed'

      @main_controller.filtered_todos.count.then do |count|
        expect(count).to eq(1)
      end
    end

    it 'should return true for all completed when all are completed' do
      @main_controller.all_complete.then do |all_complete|
        expect(all_complete).to eq(false)
      end

      # Mark all as complete
      store.todos.where(complete: false).all.each do |todo|
        todo.complete = true
      end

      @main_controller.all_complete.then do |all_complete|
        expect(all_complete).to eq(true)
      end
    end

    it 'should assign completed state to all from all_complete=' do
      @main_controller.all_complete = true

      store.todos.where(complete: true).count.then do |count|
        expect(count).to eq(3)
      end

      @main_controller.all_complete = false

      store.todos.where(complete: true).count.then do |count|
        expect(count).to eq(0)
      end

    end
  end
end