RSpec.describe Bestie::Formatter::StringUtils do
  describe 'capitalize works correctly' do
    names = [
      ['name', 'Name'],
      ['paternal surname', 'Paternal Surname'],
      ['maternal surname', 'Maternal Surname'],
      ['NAME', 'Name'],
      ['PATERNAL SURNAME', 'Paternal Surname'],
      ['MATERNAL SURNAME', 'Maternal Surname'],
      ['reyna del rocio', 'Reyna del Rocio']
    ]

    names.each do |name|
      it "for name #{name[0]}" do
        expect(Bestie::Formatter::StringUtils.capitalize(name[0])).to eq name[1]
      end
    end
  end
end
