# encoding: utf-8
def test_file
  File.open(File.expand_path('../../fixtures/files/test.txt', __FILE__), 'r:utf-8')
end
