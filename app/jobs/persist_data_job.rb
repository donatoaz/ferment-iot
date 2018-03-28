class PersistDataJob < ApplicationJob
  queue_as :readings

  def perform(datum)
    Datum.create(datum)
  end
end
