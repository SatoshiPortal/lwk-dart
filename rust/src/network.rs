use lwk_wollet::ElementsNetwork;

#[derive(Clone, Copy, PartialEq, Debug)]
pub enum LiquidNetwork {
    Mainnet,
    Testnet,
}

impl Into<ElementsNetwork> for LiquidNetwork {
    fn into(self) -> ElementsNetwork {
        match self {
            LiquidNetwork::Mainnet => ElementsNetwork::Liquid,
            LiquidNetwork::Testnet => ElementsNetwork::LiquidTestnet,
        }
    }
}
