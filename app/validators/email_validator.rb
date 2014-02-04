class EmailValidator < ActiveModel::EachValidator
  # Not sure how to avoid use of :reek:ControlParameter here
  # It's copied from somewhere else, and does it's job
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/
      record.errors.add attribute, (options[:message] || 'is not an email')
    end
  end
end
