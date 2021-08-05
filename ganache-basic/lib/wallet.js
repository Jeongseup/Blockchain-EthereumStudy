import web3Modal from "web3modal";
import Web3Adapter from "./../Utils/web3Adapter.js";

function Wallet(props) {
    // Store component to access states
    const {
        store,
        actions
    } = useContext(StoreContext);
    let [update, forceUpdate] = useState(0);

    useEffect(() => {
        if (!store.web3Adapter) {
            // connectWeb3();
        }
    }, [store]);

    const connectWeb3 = async () => {

        const web3modal = new web3Modal({
            network: "mainnet",
            providerOptions: {}
        });

        const provider = await web3modal.connect();

        const web3Adapter = new Web3Adapter(provider);

        await web3Adapter.initialize();
        actions.addWeb3Adapter(web3Adapter);
        forceUpdate(update++);
    }

    const getBalances = () => {
        if (!store.web3Adapter) { // || !store.web3Adapter.tokenBalances) || !store.web3Adapter.NFTBalance) {
            return ( <
                >
                <
                Button size = 'massive'
                color = "green"
                onClick = {
                    () => connectWeb3()
                } > Connect Wallet < /Button> <
                />
            )
        }
        return ( <
            Grid.Row centered style = {
                {
                    padding: '10px'
                }
            } >
            <
            h3 > Ethereum Address: < /h3> <
            p className = "connectedAddress" > {
                store.web3Adapter.selectedAddress
            } < /p> <
            h3 > {
                'Cash Grab NFT Balance: ' + store.web3Adapter.NFTBalance
            } < /h3> <
            /Grid.Row>
        )
    }

    // Loading if app not initialized
    if (!store) {
        return ( <
            >
            <
            Dimmer page active = {
                Boolean(props.states.isLoading)
            } >
            <
            Loader > {
                String(props.states.isLoading)
            } < /Loader> <
            /Dimmer> <
            />
        )
    }
    // App display
    else {
        return ( <
            Segment className = "container addressBar"
            style = {
                {
                    marginBottom: '50px'
                }
            } >
            <
            Grid.Row textAligned = "center" > {
                getBalances()
            } <
            /Grid.Row> <
            /Segment>
        )
    }
}