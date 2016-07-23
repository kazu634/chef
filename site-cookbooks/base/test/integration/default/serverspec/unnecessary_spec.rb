require 'serverspec'

if os[:release].to_f == 16.04 then
  # do nothing, since `serverspec` does not support `disblaed`.
end
