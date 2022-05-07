RSpec.shared_context "login_as_user" do
  before do
    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
  end
end
