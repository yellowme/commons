RSpec.describe Bestie::Formatter::RegexConstants do
  describe 'PROPER_NOUN' do
    context 'detects valid' do
      names = [
        'London',
        "Jérémie O'Co-nor",
        'Jorge Arturo',
        'Sr. Dr. Profesor Patricio',
        Faker::Name.name,
        Faker::Name.first_name,
        Faker::Name.last_name,
        Faker::Movies::StarWars.character,
      ]

      names.each do |name|
        it "for name #{name}" do
          expect(name =~ Bestie::Formatter::RegexConstants::PROPER_NOUN).to be >= 0
        end
      end
    end

    context 'detects invalid' do
      names = [
        ' London',
        'London ',
        '123456789',
        'Me?',
        '.',
        '-',
        "'",
        Faker::Internet.email,
      ]

      names.each do |name|
        it "for name #{name}" do
          expect(name =~ Bestie::Formatter::RegexConstants::PROPER_NOUN).to be_falsey
        end
      end
    end
  end

  describe 'CRUP' do
    context 'works when valid' do
      curp_list = [
        'BEML920313HMCLNS09',
        'PUXB571021HNELXR00',
        'SUPC820131HNELRS02',
        'PIMJ940217HDFNRR08',
      ]
      curp_list.each do |curp|
        it "for CURP #{curp}" do
          expect(curp =~ Bestie::Formatter::RegexConstants::CURP).to be >= 0
        end
      end
    end

    context 'fail when invalid' do
      curp_list = [
        'xxxx',
        '11111',
        'XAXX000000HXXYYY00'
      ]
      curp_list.each do |curp|
        it "for CURP #{curp}" do
          expect(curp =~ Bestie::Formatter::RegexConstants::CURP).to be_falsey
        end
      end
    end
  end

  describe 'RFC' do
    context 'works when valid' do
      rfc_list = [
        'CUPU800825569',
        'HEGJ880317LS4',
        'PUMJ810101TB9',
        'PIMJ940217CP0',
        'YME141002J52',
        'XAXX010101000',
        'XEXX010101000'
      ]
      rfc_list.each do |rfc|
        it "for RFC #{rfc}" do
          expect(rfc =~ Bestie::Formatter::RegexConstants::RFC).to be >= 0
        end
      end
    end

    context 'fail when not valid' do
      rfc_list = [
        'xxxx',
        '11111',
        'XAXX000000HXXYYY00'
      ]
      rfc_list.each do |rfc|
        it "for RFC #{rfc}" do
          expect(rfc =~ Bestie::Formatter::RegexConstants::RFC).to be_falsey
        end
      end
    end
  end
end
