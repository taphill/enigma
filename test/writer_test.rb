require './test/test_helper'

class WriterTest < Minitest::Test
  def test_it_exists
    writer = Writer.new

    assert_instance_of Writer, writer
  end
end
