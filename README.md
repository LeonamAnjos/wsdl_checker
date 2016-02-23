# Checker WSDL

Checker WSDL checks if the WSDL contract can be found and/or if it is possible to call an operation of this contract. 

  - It is a Ruby app using:
    - Thor (https://github.com/erikhuda/thor.git)
    - Savor (https://github.com/savonrb/savon.git)

### Installation
```sh
$ git clone https://github.com/LeonamAnjos/wsdl_checker
$ cd wsdl_checker
$ gem install bundler # if it is not already intalled
$ bundle
```

##### Thor installation
```sh
$ thor install lib/wsdl_checker.rb
```

### Documentation
```sh
$ thor wsdl_checker

Commands:
    checker help [COMMAND]  # Describe available commands or one specific command
    checker wsdl address    # Check the wsdl contract and send a request to a operation (optional)
Options:
      [--profile=Generate profile], [--no-profile]  
  -v, [--verbose=Be verbose], [--no-verbose]   
```
#### Example

```sh
$ thor wsdl_checker wsdl http://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx?WSDL -o calc_preco -p nCdServico:"" -v --profile
```
or
```sh
$ ./checker wsdl http://ws.correios.com.br/calculador/CalcPrecoPrazo.asmx?WSDL -o calc_preco -p nCdServico:"" -v --profile
```
