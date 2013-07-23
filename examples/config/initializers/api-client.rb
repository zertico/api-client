# Global Configuration
ApiClient.configure do |config|
  # Api path
  config.path = 'http://api.example.com'
  # Default header
  config.header = { 'param' => '123329845729384759237592348712876817234'}
  # Basic Authentication
  config.basic_auth('user', 'pass')
end