require 'test_helper'

class ControlLoopTest < ActiveSupport::TestCase
  test 'It is valid with factory defaults' do
    cl = create(:control_loop)
    assert cl.valid?
  end

  test 'It acts when in :auto mode' do
    control_loop = create(:control_loop, reference: 5)
    assert_equal :on, control_loop.run
  end
end
