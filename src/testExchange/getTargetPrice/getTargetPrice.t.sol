pragma solidity ^0.5.6;

import "ds-test/test.sol";

import "../../Prototype.sol";
import "../../ERC20Token.sol";
import "../../testSetup/setupShells.sol";

contract DappTest is DSTest, ShellSetup {

    address shell1;
    address shell2;
    uint256 shell1Liquidity;
    uint256 shell2Liquidity;

    function setUp () public {

        setupPool();
        setupTokens();
        shell1 = setupShellAB();
        shell2 = setupShellABC();

        shell1Liquidity = pool.depositLiquidity(shell1, 10000 * ( 10 ** 18));
        shell2Liquidity = pool.depositLiquidity(shell2, 30000 * ( 10 ** 18));

        pool.activateShell(shell1);
        pool.activateShell(shell2);

    }


    function testGetTargetPrice () public {

        uint256 price1 = pool.getTargetPrice(100 * ( 10 ** 18 ), address(testA), address(testB));
        assertEq(price1, 100671140939597315436);
        pool.swapByTarget(100 * ( 10 ** 18 ), address(testA), address(testB));

        uint256 price2 = pool.getTargetPrice(100 * ( 10 ** 18 ), address(testB), address(testA));
        assertEq(price2, 99328889087736566597);
        pool.swapByTarget(100 * ( 10 ** 18 ), address(testB), address(testA));

        uint256 price3 = pool.getTargetPrice(100 * ( 10 ** 18 ), address(testA), address(testC));
        assertEq(price3, 101014620477707726030);
        pool.swapByTarget(100 * ( 10 ** 18 ), address(testA), address(testC));

        uint256 price4 = pool.getTargetPrice(100 * ( 10 ** 18), address(testC), address(testB));
        assertEq(price4, 100004519469649275597);

    }

}