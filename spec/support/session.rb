RSpec.shared_context :login_cliente_user, shared_context: :metadata do
  before do
    @cliente_user = FactoryBot.create(:user)
    sign_in(@cliente_user)
  end
end

RSpec.configure do |rspec|
  rspec.include_context :login_cliente_user, include_shared: true
end