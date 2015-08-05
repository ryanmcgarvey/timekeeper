class ClientHelper
  include CapybaraHelpers

  def go_home
    visit '/clients'
  end

  def add_client(name)
    find("[role='add_client']").click
    within 'form' do
      fill_in 'Name', with: name
      click_on 'Add Client'
    end
  end

  def visit_client(name)
    within client_list.row_with_text(name) do
      click_on name
    end
  end

  def client_list
    TableHelper.new "table[role='client_list']"
  end

  def add_profile(client, profile_name)
    within client_list.row_with_text(client) do
      click_on "Add Profile"
    end
    fill_in "Name", with: profile_name
    click_on 'Add Client Profile'
  end

  def edit_profile(client, old_profile_name, new_profile_name)
    within client_list.row_with_text("Client 1") do
      click_on(old_profile_name)
    end
    fill_in "Name", with: new_profile_name
    click_on 'Update Client Profile'
  end
end
