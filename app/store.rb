class Store
  include Inesita::Injection

  attr_accessor :state

  def init
    @storage = Browser::Storage.new(JS.global, 'global_storage')
    @state = {}
  end
end
