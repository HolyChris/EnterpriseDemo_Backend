ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel 'Top 10 Customers' do
          table_for Customer.created_by_or_assigned_to(current_user).order(updated_at: :desc).limit(10) do
            column :firstname
            column :lastname
            column :email
            column 'Actions' do |customer|
              html = [link_to('View', admin_customer_url(customer))]
              html << link_to('Sites', admin_customer_sites_url(customer))
              html.join(' ').html_safe
            end
          end
          strong { link_to "View All >>", admin_customers_path }
        end
      end

      column do
        panel 'Top 10 Sites' do
          table_for Site.created_by_or_assigned_to(current_user).order(updated_at: :desc, status: :asc).limit(10) do
            column 'Site Name' do |site|
              site.name
            end

            column 'Managers' do |site|
              site.managers.pluck(:email).join(', ')
            end

            column 'Source' do |site|
              site.source_string
            end
            column 'Opportunity Priority' do |site|
              site.status_string
            end
            column 'Address' do |site|
              site.address.full_address
            end
            column 'Actions' do |site|
              html = [link_to('View', admin_site_url(site))]
              html << link_to('Edit', edit_admin_site_url(site))
              html.join(' ').html_safe
            end
          end
          strong { link_to "View All >>", admin_sites_path }
        end
      end
    end
  end
end
