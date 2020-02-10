module Commons
  module Formatter
    module RegexConstants
      PROPER_NOUN = /\A\p{L}[\p{L}'\.\-]*( [\p{L}'\.\-]+)*\z/u
      CURP = /\A([A-Z][AEIOUX][A-Z]{2}\d{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[12]\d|3[01])[HM](?:AS|B[CS]|C[CLMSH]|D[FG]|G[TR]|HG|JC|M[CNS]|N[ETL]|OC|PL|Q[TR]|S[PLR]|T[CSL]|VZ|YN|ZS)[B-DF-HJ-NP-TV-Z]{3}[A-Z\d])(\d)\z/
      RFC = /\A([A-ZÑ\x26]{3,4}(\d{2})(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[0-1])([A-Z0-9]){2}([A0-9]))?\z/i
      ELECTOR_KEY = /\A(?:[A-Z][B-DF-HJ-NP-TV-Z]){3}\d{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[12]\d|3[01])(?:0[1-9]|[12]\d|3[0-2]|99)[A-Z]\d{3}\z/
      MONEY = /\A[+-]?\d+(\.\d{1,6})?\z/
    end
  end
end
