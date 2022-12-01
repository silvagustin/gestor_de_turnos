RSpec.shared_context :login_cliente_user, shared_context: :metadata do
  before do
    @cliente_user = FactoryBot.create(:user)
    sign_in(@cliente_user)
  end
end

RSpec.shared_context :login_personal_bancario_user, shared_context: :metadata do
  before do
    @personal_bancario_user = FactoryBot.create(:user, :personal_bancario)
    sign_in(@personal_bancario_user)
  end
end

RSpec.shared_context :login_administrador_user, shared_context: :metadata do
  before do
    @administrador_user = FactoryBot.create(:user, :administrador)
    sign_in(@administrador_user)
  end
end

RSpec.configure do |rspec|
  rspec.include_context :login_cliente_user, include_shared: true
  rspec.include_context :login_personal_bancario_user, include_shared: true
  rspec.include_context :login_administrador_user, include_shared: true
end