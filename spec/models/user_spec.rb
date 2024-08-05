require 'rails_helper'

RSpec.describe User, type: :model do
  it "successfuly creates the record" do
    user = User.new(
      first_name: "First Name",
      last_name: "Last Name",
      email: "test@email.com",
      password: "test"
    )

    user.save

    expect(User.count).to be(1)
  end

  it "successfuly updates the record" do
    user = User.new(
      first_name: "First Name",
      last_name: "Last Name",
      email: "test@email.com",
      password: "test"
    )

    user.save

    user.first_name = "New First Name"
    user.last_name = "New Last Name"
    user.email = "new_email@email.com"
    user.password = "new_password"

    user.save

    expect(user).to have_attributes(
                   first_name: "New First Name",
                   last_name: "New Last Name",
                   email: "new_email@email.com",
                   password: "new_password"
                 )
  end

  it "successfully deletes the record" do
    user = User.new(
      first_name: "First Name",
      last_name: "Last Name",
      email: "test@email.com",
      password: "test"
    )

    user.save

    expect { user.destroy }.to change { User.count }.by(-1)
  end

  it "triggers first_name column validation" do
    user = User.new(
      first_name: "",
      last_name: "Last Name",
      email: "test@email.com",
      password: "test"
    )

    user.save

    expect(user.errors[:first_name].any?).to be(true)
  end

  it "triggers last_name column validation" do
    user = User.new(
      first_name: "First Name",
      last_name: "",
      email: "test@email.com",
      password: "test"
    )

    user.save

    expect(user.errors[:last_name].any?).to be(true)
  end

  it "triggers email column validation" do
    user = User.new(
      first_name: "First name",
      last_name: "Last Name",
      email: "",
      password: "test"
    )

    user.save

    expect(user.errors[:email].any?).to be(true)
  end

  it "triggers password column validation" do
    user = User.new(
      first_name: "First Name",
      last_name: "Last Name",
      email: "test@email.com",
      password: ""
    )

    user.save

    expect(user.errors[:password].any?).to be(true)
  end
end
