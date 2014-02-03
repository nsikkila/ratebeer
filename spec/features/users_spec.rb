require 'spec_helper'

describe "User" do
	before :each do
		FactoryGirl.create :user
	end

	describe "who has signed up" do
		
		it "can sign in with right credentials" do
			visit signin_path
			fill_in('username', with:'Pekka')
			fill_in('password', with:'Foobar1')
			click_button('Log in')

			expect(page).to have_content 'Welcome back!'
			expect(page).to have_content 'Pekka'
		end

		it "is redirected back to signin form if wrong credentials given" do
			visit signin_path
			fill_in('username', with:'Pekka')
			fill_in('password', with:'wrong')
			click_button('Log in')

			expect(current_path).to eq(signin_path)
			expect(page).to have_content 'Incorrect username or password'
		end

	end
end
