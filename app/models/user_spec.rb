require 'spec_helper'

descirbe User do
  before{ @user = User.new(name: "Example user", email:"user@example.com")}
  subject{ @user }
  it{ should respond_to(:name) }
  it{ should respond_to(:email) }
  it{ should respond_to(:password_digest)}
  it{ should respond_to(:password)}
  it{ should respond_to(:password_confirmation)}

  it{ should be_valid }

  describe "when name is not present" do
    before { @user.name = ""}
    it{ should_not be_valid}
  end
  describe "when email is not present" do
    before{ @user.email = ""}
    it{ should_not be_valid}
  end
  describe "when email format is invalid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US]-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        should be_valid
      end
    end
  end
  describe "when email address is alreaady taken" do
    before do
     user_with_same_email = @user.dup
     user_with_same_email.email = @user.email.upcase
     user_with_same_email.save
    end
    it {should_not be_valid}
  end
  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMple.CoM"}
    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it{ should be_invalid}
  end
  # authenticateメソッド検証
  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    # passwordが正しい場合
    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    # passwordが不正である場合
    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end
end
