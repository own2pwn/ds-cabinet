class TopicObserver < ActiveRecord::Observer
  def after_create(record)
    if record.user.concierge
      Notification.create(
        user: record.user.concierge,
        object: record,
        name: 'topic_created'
      )
    end
  end
end