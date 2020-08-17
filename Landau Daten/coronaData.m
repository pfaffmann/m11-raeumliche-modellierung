% Last Date: 12.4.2020
function y= coronaData ()
	infects = [    16.0     18.0     21.0     26.0     53.0     66.0    117.0    150.0    188.0    240.0    400.0    639.0    795.0    902.0   1139.0   1296.0   1567.0   2369.0   3062.0   3795.0   4838.0   6012.0   7156.0   8198.0  10999.0  13957.0  16662.0  18610.0  22672.0  27436.0  31554.0  36508.0  42288.0  48582.0  52547.0  57298.0  61913.0  67366.0  73522.0  79696.0  85778.0  91714.0  95391.0  99225.0 103228.0 108202.0 113525.0 117658.0 120479.0 123016.0 125098.0 127584.0 130450.0 133830.0 137439.0 139897.0 141672.0 143457.0 145694.0 148046.0 150383.0 152438.0 154175.0 155193.0 156337.0 157641.0 159119.0 160758.0 161703.0 162496.0 163175.0 163860.0 164807.0 166091.0 167300.0 168531.0 169218.0 169575.0 170508.0 171306.0 172239.0 173152.0 173772.0 174355.0 174697.0 175210.0 176007.0 176752.0 177212.0 177850.0 178281.0 178570.0 179002.0 179364.0 179717.0 180458.0 181196.0 181482.0 181815.0 182028.0 182370.0 182764.0 182937.0 183271.0 183979.0 184193.0 184543.0 184861.0 185416.0 185674.0 186022.0 186269.0 186461.0 186839.0 187184.0 187764.0 188534.0 189135. 189822.00 190359.0 190862.0 191449.0 192079.0 192556.0 193243.0 193499.0 193761.0 194259.0];
	deads = [   0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0    0.0   12.0   20.0   31.0   46.0   55.0   86.0  114.0  149.0  198.0  253.0  325.0  389.0  455.0  583.0  732.0  872.0 1017.0 1158.0 1342.0 1434.0 1607.0 1861.0 2107.0 2373.0 2544.0 2673.0 2799.0 2969.0 3254.0 3569.0 3868.0 4110.0 4294.0 4404.0 4598.0 4879.0 5094.0 5321.0 5500.0 5640.0 5750.0 5913.0 6115.0 6288.0 6481.0 6575.0 6649.0 6692.0 6831.0 6996.0 7119.0 7266.0 7369.0 7395.0 7417.0 7533.0 7634.0 7723.0 7824.0 7881.0 7914.0 7935.0 8007.0 8090.0 8147.0 8174.0 8216.0 8247.0 8257.0 8302.0 8349.0 8411.0 8450.0 8489.0 8500.0 8511.0 8522.0 8551.0 8581.0 8614.0 8646.0 8668.0 8674.0 8711.0 8729.0 8755.0 8763.0 8781.0 8787.0 8791.0 8800.0 8830.0 8856.0 8872.0 8883.0 8882.0 8885.0 8895.0 8914.0 8927.0 8948.0 8954.0 8957.0 8961.0 8973.0];
    recovered = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 13500.0, 16100.0, 18700.0, 21400.0, 23800.0, 26400.0, 28700.0, 30600.0, 33000.0, 46300.0, 49000.0, 53913.0 57400.0 60200.0 64300.0 68200.0 72600.0 77000.0 81800.0 85400.0 88000.0 91500.0 95200.0 99400.0 103300.0 106800.0 109800.0 112000 114500 117400.0 120400.0 123500.0 126900.0 129000.0 130600.0 132700.0 135100.0 137400.0 139900.0 141700.0 143300.0 144400.0 145600.0 147200.0 148700.0 150300.0 151700.0 152600.0 153400.0 154600.0 155700.0 156900.0 158000.0 159000.0 159900.0 160500.0 161200.0 162000.0 162800.0 163200.0 164100.0 164900.0 165200.0 165900.0 166400.0 167300.0 167800.0 168300.0 168800.0 169100.0 169600.0 170200.0 170700.0 171100.0 171600.0 171900.0 172200.0 172650.0 173100.0 173600.0 174100.0 174400.0 174700.0 174900.0 175300.0 175700.0 176300.0 176800.0 177100.0 177500.0 177700.0 178100.0 179100.0];
	y=[infects;deads;recovered];
endfunction