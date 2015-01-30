Redmine::Plugin.register :redmine_app_notifications do
  name 'Redmine App Notifications plugin'
  author 'Michal Vanžura'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  menu :top_menu, :app_notifications, { :controller => 'app_notifications', :action => 'index' }, {
  	:caption => :notifications, 
  	:last => true, 
  	:if => Proc.new { User.current.app_notification },
    :html => {:id => 'notificationsLink'}
  }
  
  menu :top_menu, :app_notifications_count, { :controller => 'app_notifications', :action => 'index' }, {
    :caption => Proc.new { AppNotification.where(recipient_id: User.current.id, viewed: false).count.to_s }, 
    :last => true, 
    :if => Proc.new { User.current.app_notification && AppNotification.where(recipient_id: User.current.id, viewed: false).count > 0 },
    :html => {:id => 'notification_count'}
  }

  settings :default => [
      'issue_added',
      'issue_updated', 
      'issue_note_added', 
      'issue_status_updated', 
      'issue_assigned_to_updated', 
      'issue_priority_updated'
    ], :partial => 'settings/app_notifications_settings'
end

require_dependency 'app_notifications_hook_listener'
require_dependency 'app_notifications_account_patch'
require_dependency 'app_notifications_helper'
