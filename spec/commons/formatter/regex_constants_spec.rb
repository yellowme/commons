RSpec.describe Commons::Formatter::RegexConstants do
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
          expect(name =~ Commons::Formatter::RegexConstants::PROPER_NOUN).to be >= 0
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
          expect(name =~ Commons::Formatter::RegexConstants::PROPER_NOUN).to be_falsey
        end
      end
    end
  end

  describe 'CURP' do
    context 'works when valid' do
      curp_list = [
        'BEML920313HMCLNS09',
        'PUXB571021HNELXR00',
        'SUPC820131HNELRS02',
        'PIMJ940217HDFNRR08',
      ]
      curp_list.each do |curp|
        it "for CURP #{curp}" do
          expect(curp =~ Commons::Formatter::RegexConstants::CURP).to be >= 0
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
          expect(curp =~ Commons::Formatter::RegexConstants::CURP).to be_falsey
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
          expect(rfc =~ Commons::Formatter::RegexConstants::RFC).to be >= 0
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
          expect(rfc =~ Commons::Formatter::RegexConstants::RFC).to be_falsey
        end
      end
    end
  end

  describe 'ELECTOR_KEY' do
    context 'works when valid' do
      elector_list = [
        'PXMXJX94021709H000',
        'OXSXJX96062909H000',
      ]
      elector_list.each do |k|
        it "for clave #{k}" do
          expect(k =~ Commons::Formatter::RegexConstants::ELECTOR_KEY).to be >= 0
        end
      end
    end

    context 'fail when not valid' do
      elector_list = [
        'xxxx',
        '11111',
        'XAXX000000HXXYYY00'
      ]
      elector_list.each do |k|
        it "for clave #{k}" do
          expect(k =~ Commons::Formatter::RegexConstants::ELECTOR_KEY).to be_falsey
        end
      end
    end
  end

  describe 'MONEY' do
    context 'works when valid' do
      number_list = [
        '10.00',
        '1',
        '-1.0',
        '+1.0',
        '0.000001',
        '10000.000',
        '99999999999999999999999999999999999999',
        '99999999999999999999999999999999999999.999999',
        '0',
      ]
      number_list.each do |number|
        it "for number #{number}" do
          expect(number =~ Commons::Formatter::RegexConstants::MONEY).to be >= 0
        end
      end
    end

    context 'fail when not valid' do
      number_list = [
        '',
        ' 0.0 ',
        '0.0000001',
        '$0.00',
        '.1'
      ]
      number_list.each do |number|
        it "for number #{number}" do
          expect(number =~ Commons::Formatter::RegexConstants::MONEY).to be_falsey
        end
      end
    end
  end
end
