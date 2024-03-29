[@inline] function getOraclePriceView(
    const oracleAddress   : address;
    const asset           : string)
                          : nat is
    unwrap(
      (Tezos.call_view("get_price", asset, oracleAddress)
                          : option(nat)),
      Errors.wrongOContract
    );

function getPrice(
  const tokenSet        : tokenSet;
  const s               : parserStorage)
                        : parserReturn is
  block {
    const tezToUsdPrice : nat = getOraclePriceView(s.oracle, xtz_usd_price_name);
    function oneTokenUpd(
      const operations  : list(operation);
      const tokenId     : nat)
                        : list(operation) is
      block {
        const strName : string = checkAssetName(tokenId, s.assetName);
        const oraclePrice : nat = getOraclePriceView(s.oracle, strName);
        const usd : bool = (strName = xtz_usd_price_name); // if price is XTZ/USD
        const priceF : precisionValue = if (usd)  // then this is the USD-peg and we should
          then s.oraclePrecision * precision / oraclePrice // invert to USD/XTZ (1/priceF)
          else oraclePrice * precision / tezToUsdPrice; // else divide by XTZ/USD price to send XTZ-related price
        const tokenId : nat = checkAssetId(strName, s.assetId);
        var op : operation := Tezos.transaction(
          record [
            tokenId = tokenId;
            priceF = priceF;
          ],
          0mutez,
          getRouterPriceCallbackMethod(s.router)
        );
      } with op # operations;
    const operations = Set.fold(
      oneTokenUpd,
      tokenSet,
      (nil : list(operation))
    )
  } with (operations, s)