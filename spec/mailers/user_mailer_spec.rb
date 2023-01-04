require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "welcome" do
    email = "example@example.com"
    first_name = "first"
    url = "localhost:3000/user/12/activate"

    let(:mail) { UserMailer.welcome(email, first_name, url) }

    it "renders the headers" do
      expect(mail.subject).to eq("Welcome")
      expect(mail.to).to eq([email])
      expect(mail.from).to eq(["ShrimpersRepublic@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Welcome to Shrimp Republic #{first_name}. Please click the following link to activate your account: #{url}")
    end
  end

end
