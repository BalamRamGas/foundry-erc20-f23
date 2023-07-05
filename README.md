# OurToken

OurToken is an ERC20 token implementation based on the OpenZeppelin library. It provides a basic token contract with functionalities such as token transfers, allowances, and balance tracking.

## Features

- ERC20 compliant token
- Customizable token name and symbol
- Initial token supply set during deployment

## Getting Started

### Prerequisites

- Foundry

### Installation

1. Clone the repository: git clone https://github.com/your-username/our-token.git

2. Navigate to the project directory: cd our-token

3. Install the dependencies / libraries.

### Usage

1. Modify the token parameters:
   In the OurToken.sol file, you can customize the name, symbol, and initial supply of the token. By default, it is set to "OurToken" and "OT" with the initial supply specified during deployment.

2. Compile the smart contract: forge compile / forge build

3. Run the tests: forge test

4. Open a pull request.

### License

OurToken is licensed under the MIT License.

## Acknowledgements

- This project uses the OpenZeppelin library for the ERC20 token implementation.
- Special thanks to the Foundry framework for providing testing utilities.
