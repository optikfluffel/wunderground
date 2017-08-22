defmodule Wunderground.Query do
  @moduledoc false

  @type us_state_city :: {:us, String.t, String.t}
  @type us_zip :: {:us_zip, non_neg_integer}
  @type international :: {:international, String.t, String.t}
  @type lat_lng :: {:geo, float, float}
  @type airport :: {:airport, String.t}
  @type pws :: {:pws, String.t}
  @type auto_ip :: {:auto_ip} |
                   {:auto_ip, {non_neg_integer, non_neg_integer, non_neg_integer, non_neg_integer}}

  @type t :: us_state_city |
             us_zip |
             international |
             lat_lng |
             airport |
             pws |
             auto_ip
end
