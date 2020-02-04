def phone_list
  [
    { phone: '+1 (415) 555-3695', format: '+14155553695', custom_format: nil },
    { phone: '5345 8120', format: "+5353458120", custom_format: nil },
    { phone: '898 5754', format: nil, custom_format: nil }, # local
    { phone: '208 516 7431', format: nil, custom_format: nil }, # USA pero sin +1
    { phone: '+57 301 2665494', format: '+573012665494', custom_format: nil }, # Colombia
    { phone: '+54 9 342 429 8094', format: '+5493424298094', custom_format: nil }, # Argentina móvil
    { phone: '+1 712-269-8405', format: '+17122698405', custom_format: nil },
    { phone: '+52 998 260 0303', format: '+529982600303', custom_format: '+529982600303' },
    { phone: '+52 998 260 0550', format: '+529982600550', custom_format: '+529982600550' },
    { phone: '999 227 4887', format: '+529992274887', custom_format: '+529992274887' },
    { phone: '998 260 0550', format: '+529982600550', custom_format: '+529982600550' },
    { phone: '998 260 0303', format: '+529982600303', custom_format: '+529982600303' },
    # El siguiente número es USA pero sin +1 pasa todas las validaciones, es un falso positivo
    { phone: '712-269-8405', format: '+527122698405', custom_format: '+527122698405' },
    { phone: '999 926 3252', format: '+529999263252', custom_format: '+529999263252' }, # MX local
    { phone: '998-898-5754', format: '+529988985754', custom_format: '+529988985754' },
    { phone: '722.196.0105', format: '+527221960105', custom_format: '+527221960105' },
    # Número de USA pero sin (+)
    { phone: '1832 928 5078', format: '+528329285078', custom_format: nil },
    { phone: '+1 (972) 3636278', format: '+19723636278', custom_format: nil },
    { phone: '+ 1 (832) 928 5078', format: '+18329285078', custom_format: nil },
    { phone: '8880178769', format: '+528880178769', custom_format: '+528880178769' },
    { phone: '+5218880178769', format: '+528880178769', custom_format: '+528880178769' },
  ]
end

RSpec.describe Commons::Formatter::E164Phone do
  describe 'valid for México' do
    phone_list.each do |testCase|
      context "number #{testCase[:phone]}" do
        formatter = Commons::Formatter::E164Phone.new(testCase[:phone])
        formatted_phone = formatter.format
        it { expect(formatted_phone).to eq testCase[:format] }
       end
    end
  end

  context 'with valid phone numbers' do
    test_cases = [
      { phone: '(999)1485541', result: '+529991485541' },
      { phone: '+5219991485541', result: '+529991485541' },
      { phone: '999 1 48 55 41', result: '+529991485541' },
      { phone: '999-1-48-55-41', result: '+529991485541' },
      { phone: '+529991485541', result: '+529991485541' },
      { phone: '019991485541', result: '+529991485541' },
      { phone: '019991485541', result: '+529991485541' },
    ]

    test_cases.each do |test_case|
      context "number #{test_case[:phone]}" do
        subject { Commons::Formatter::E164Phone.new(test_case[:phone]) }

        it { expect(subject.format).to eq test_case[:result] }
      end
    end
  end

  context 'invalid phone numbers' do
    test_cases = [
      { phone: ')' },
      { phone: '()' },
      { phone: '' },
    ]

    test_cases.each do |test_case|
      context "number #{test_case[:phone]}" do
        subject { Commons::Formatter::E164Phone.new(test_case[:phone]) }

        it { expect(subject.format).to be_nil }
      end
    end
  end

  context 'format_national works ok!' do
    test_cases = [
      { phone: '9991485541', result: '9991485541' },
      { phone: '(999)1485541', result: '9991485541' },
      { phone: '+5219991485541', result: '9991485541' },
      { phone: '999 1 48 55 41', result: '9991485541' },
      { phone: '999-1-48-55-41', result: '9991485541' },
      { phone: '+529991485541', result: '9991485541' },
      { phone: '019991485541', result: '9991485541' },
      { phone: '019991485541', result: '9991485541' },
    ]

    test_cases.each do |test_case|
      context "number #{test_case[:phone]}" do
        subject { Commons::Formatter::E164Phone.new(test_case[:phone]) }

        it { expect(subject.format_national).to eq test_case[:result] }
      end
    end
  end

  context 'format_extension works ok!' do
    test_cases = [
      { phone: '+5219991485541', result: '52' },
      { phone: '+529991485541', result: '52' },
      { phone: '+1 (972) 3636278', result: '1' },
      { phone: '+ 1 (832) 928 5078', result: '1' },
      { phone: '+57 301 2665494', result: '57' },
      { phone: '+54 9 342 429 8094', result: '54' },
    ]

    test_cases.each do |test_case|
      context "number #{test_case[:phone]}" do
        subject { Commons::Formatter::E164Phone.new(test_case[:phone]) }

        it { expect(subject.country_code).to eq test_case[:result] }
      end
    end
  end

  describe 'canonical_phone' do
    context 'matches valid phones' do
      test_cases = [
        { phone: '+5219991485541', result: '9991485541' },
        { phone: '+529991485541', result: '9991485541' },
        { phone: '9723636278', result: '9723636278' },
        { phone: '  (832) 928 5078', result: '8329285078' },
        { phone: '+52 301 2665494', result: '3012665494' },
        { phone: '+52 342 429 8094', result: '3424298094' },
      ]

      test_cases.each do |test_case|
        context "number #{test_case[:phone]}" do
          subject { Commons::Formatter::E164Phone.canonical_phone(test_case[:phone]) }

          it { expect(subject).to eq test_case[:result] }
        end
      end
    end

    context 'do not match invalid phones' do
      test_cases = [
        '+52219991485541',
        '+5229991485541',
        '+1 (972) 3636278',
        '+ 1 (832) 928 5078',
        '+57 301 2665494',
        '+54 9 342 429 8094',
      ]

      test_cases.each do |test_case|
        context "number #{test_case}" do
          subject { Commons::Formatter::E164Phone.canonical_phone(test_case) }

          it { expect(subject).to be_nil }
        end
      end
    end
  end
end
