use lwk_wollet::ElementsNetwork;

#[derive(Clone, Copy, PartialEq, Debug)]
pub enum Network {
    Mainnet,
    Testnet,
}

impl Into<ElementsNetwork> for Network {
    fn into(self) -> ElementsNetwork {
        match self {
            Network::Mainnet => ElementsNetwork::Liquid,
            Network::Testnet => ElementsNetwork::LiquidTestnet,
        }
    }
}
