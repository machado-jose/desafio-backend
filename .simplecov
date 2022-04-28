SimpleCov.start 'rails' do
  add_group 'Services', 'app/services'

  # Filters
  add_filter [
    'app/jobs',
    'app/mailers',
    'app/views',
    'app/channels'
  ]
end
