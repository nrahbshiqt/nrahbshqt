/*
 Navicat Premium Data Transfer

 Source Server         : 47.242.132.97
 Source Server Type    : MySQL
 Source Server Version : 50729
 Source Host           : 47.242.132.97:3306
 Source Schema         : huobi_project

 Target Server Type    : MySQL
 Target Server Version : 50729
 File Encoding         : 65001

 Date: 28/02/2021 19:59:21
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account_asset_valuation_table
-- ----------------------------
DROP TABLE IF EXISTS `account_asset_valuation_table`;
CREATE TABLE `account_asset_valuation_table`  (
  `account_id` bigint(20) NOT NULL COMMENT 'account_id',
  `valuation_currency` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '资产估值法币',
  `balance` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '总资产估值',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`account_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '账户的总资产估值' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for account_balance_table
-- ----------------------------
DROP TABLE IF EXISTS `account_balance_table`;
CREATE TABLE `account_balance_table`  (
  `account_id` bigint(20) NOT NULL COMMENT 'account_id',
  `balance` decimal(20, 7) NULL DEFAULT NULL COMMENT '余额	',
  `currency` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '币种	',
  `balance_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型	trade: 交易余额，frozen: 冻结余额, loan: 待还借贷本金, interest: 待还借贷利息, lock: 锁仓, bank: 储蓄'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '账户余额' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for account_table
-- ----------------------------
DROP TABLE IF EXISTS `account_table`;
CREATE TABLE `account_table`  (
  `account_id` bigint(20) NOT NULL COMMENT 'account_id',
  `state` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '账户状态	working：正常, lock：账户被锁定',
  `account_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '账户类型	spot：现货账户, margin：逐仓杠杆账户, otc：OTC 账户, point：点卡账户, super-margin：全仓杠杆账户, investment: C2C杠杆借出账户, borrow: C2C杠杆借入账户，矿池账户: minepool, ETF账户: etf, 抵押借贷账户: crypto-loans',
  `subtype` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子账户类型（仅对逐仓杠杆账户有效）	逐仓杠杆交易标的，例如btcusdt',
  PRIMARY KEY (`account_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '账户信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for boll_index_table
-- ----------------------------
DROP TABLE IF EXISTS `boll_index_table`;
CREATE TABLE `boll_index_table`  (
  `id` bigint(20) NOT NULL COMMENT 'unix时间，同时作为K线ID',
  `symbol` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '交易代码	btcusdt, ethbtc...等（如需获取杠杆ETP净值K线，净值symbol = 杠杆ETP交易对symbol + 后缀‘nav’，例如：btc3lusdtnav）',
  `period` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'K线周期	1min, 5min, 15min, 30min, 60min, 4hour, 1day, 1mon, 1week, 1year',
  `up` decimal(20, 7) NULL DEFAULT NULL COMMENT '上轨',
  `mb` decimal(20, 7) NULL DEFAULT NULL COMMENT '中轨',
  `dn` decimal(20, 7) NULL DEFAULT NULL COMMENT '下轨',
  `width` decimal(20, 7) NULL DEFAULT NULL COMMENT '宽度',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`, `symbol`, `period`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '布林线表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for chain_table
-- ----------------------------
DROP TABLE IF EXISTS `chain_table`;
CREATE TABLE `chain_table`  (
  `unq_key` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `currency` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '币种',
  `chain` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `display_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '链显示名称',
  `base_chain` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '底层链名称',
  `base_chain_protocol` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '	底层链协议',
  `is_dynamic` tinyint(4) NULL DEFAULT NULL COMMENT '是否动态手续费（仅对固定类型有效，withdrawFeeType=fixed）',
  `num_of_confirmations` int(1) NULL DEFAULT NULL COMMENT '安全上账所需确认次数（达到确认次数后允许提币）',
  `num_of_fast_confirmations` int(1) NULL DEFAULT NULL COMMENT '快速上账所需确认次数（达到确认次数后允许交易但不允许提币）',
  `min_deposit_amt` decimal(20, 7) NULL DEFAULT NULL COMMENT '单次最小充币金额',
  `deposit_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '充币状态 allowed,prohibited',
  `min_withdraw_amt` decimal(20, 7) NULL DEFAULT NULL COMMENT '单次最小提币金额',
  `max_withdraw_amt` decimal(20, 7) NULL DEFAULT NULL COMMENT '单次最大提币金额',
  `withdraw_quota_per_day` decimal(20, 7) NULL DEFAULT NULL COMMENT '当日提币额度（新加坡时区）',
  `withdraw_quota_per_year` decimal(20, 7) NULL DEFAULT NULL COMMENT '当年提币额度',
  `withdraw_quota_total` decimal(20, 7) NULL DEFAULT NULL COMMENT '总提币额度',
  `withdraw_precision` decimal(20, 7) NULL DEFAULT NULL COMMENT '提币精度',
  `withdraw_fee_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '提币手续费类型（特定币种在特定链上的提币手续费类型唯一）fixed,circulated,ratio',
  `transact_fee_withdraw` decimal(20, 7) NULL DEFAULT NULL COMMENT '单次提币手续费（仅对固定类型有效，withdrawFeeType=fixed）',
  `min_transact_fee_withdraw` decimal(20, 7) NULL DEFAULT NULL COMMENT '	最小单次提币手续费（仅对区间类型和有下限的比例类型有效，withdrawFeeType=circulated or ratio）',
  `max_transact_fee_withdraw` decimal(20, 7) NULL DEFAULT NULL COMMENT '	最大单次提币手续费（仅对区间类型和有上限的比例类型有效，withdrawFeeType=circulated or ratio）',
  `transact_fee_rate_withdraw` decimal(20, 7) NULL DEFAULT NULL COMMENT '单次提币手续费率（仅对比例类型有效，withdrawFeeType=ratio）',
  `withdraw_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '提币状态 allowed,prohibited',
  `inst_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '币种状态 normal,delisted',
  PRIMARY KEY (`unq_key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '币链参考信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for currency_table
-- ----------------------------
DROP TABLE IF EXISTS `currency_table`;
CREATE TABLE `currency_table`  (
  `name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '币种名称',
  PRIMARY KEY (`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '当前交易所有币种' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for kline_table
-- ----------------------------
DROP TABLE IF EXISTS `kline_table`;
CREATE TABLE `kline_table`  (
  `id` bigint(20) NOT NULL COMMENT 'unix时间，同时作为K线ID',
  `symbol` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '交易代码	btcusdt, ethbtc...等（如需获取杠杆ETP净值K线，净值symbol = 杠杆ETP交易对symbol + 后缀‘nav’，例如：btc3lusdtnav）',
  `period` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'K线周期	1min, 5min, 15min, 30min, 60min, 4hour, 1day, 1mon, 1week, 1year',
  `amount` decimal(30, 15) NULL DEFAULT NULL COMMENT '成交量',
  `count` decimal(11, 0) NULL DEFAULT NULL COMMENT '	成交笔数',
  `open` decimal(20, 7) NULL DEFAULT NULL COMMENT '开盘价',
  `close` decimal(20, 7) NULL DEFAULT NULL COMMENT '收盘价（当K线为最晚的一根时，是最新成交价）',
  `low` decimal(20, 7) NULL DEFAULT NULL COMMENT '最低价',
  `high` decimal(20, 7) NULL DEFAULT NULL COMMENT '最高价',
  `vol` decimal(30, 15) NULL DEFAULT NULL COMMENT '成交额, 即 sum(每一笔成交价 * 该笔的成交量)',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`, `symbol`, `period`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'K线数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for symbol_table
-- ----------------------------
DROP TABLE IF EXISTS `symbol_table`;
CREATE TABLE `symbol_table`  (
  `unq_key` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `base_currency` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交易对中的基础币种',
  `quote_currency` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交易对中的报价币种',
  `price_precision` int(1) NULL DEFAULT NULL COMMENT '交易对报价的精度（小数点后位数）',
  `amount_precision` int(1) NULL DEFAULT NULL COMMENT '交易对基础币种计数精度（小数点后位数）',
  `symbol_partition` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交易区，可能值: [main，innovation]',
  `symbol` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交易对',
  `state` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '交易对状态； online _ 已上线；offline _ 交易对已下线，不可交易；suspend __ 交易暂停；pre_online _ 即将上线',
  `value_precision` int(1) NULL DEFAULT NULL COMMENT '交易对交易金额的精度（小数点后位数）',
  `min_order_amt` decimal(20, 7) NULL DEFAULT NULL COMMENT '交易对限价单最小下单量 ，以基础币种为单位（即将废弃）',
  `max_order_amt` decimal(20, 7) NULL DEFAULT NULL COMMENT '交易对限价单最大下单量 ，以基础币种为单位（即将废弃）',
  `limit_order_min_order_amt` decimal(20, 7) NULL DEFAULT NULL COMMENT '交易对限价单最小下单量 ，以基础币种为单位（NEW）',
  `limit_order_max_order_amt` decimal(20, 7) NULL DEFAULT NULL COMMENT '交易对限价单最大下单量 ，以基础币种为单位（NEW）',
  `sell_market_min_order_amt` decimal(20, 7) NULL DEFAULT NULL COMMENT '交易对市价卖单最小下单量，以基础币种为单位（NEW）',
  `sell_market_max_order_amt` decimal(20, 7) NULL DEFAULT NULL COMMENT '交易对市价卖单最大下单量，以基础币种为单位（NEW）',
  `buy_market_max_order_value` decimal(20, 7) NULL DEFAULT NULL COMMENT '交易对市价买单最大下单金额，以计价币种为单位（NEW）',
  `min_order_value` decimal(20, 7) NULL DEFAULT NULL COMMENT '交易对限价单和市价买单最小下单金额 ，以计价币种为单位',
  `max_order_value` decimal(20, 7) NULL DEFAULT NULL COMMENT '交易对限价单和市价买单最大下单金额 ，以折算后的USDT为单位（NEW）',
  `leverage_ratio` decimal(20, 7) NULL DEFAULT NULL COMMENT '交易对杠杆最大倍数(仅对逐仓杠杆交易对、全仓杠杆交易对、杠杆ETP交易对有效）',
  `underlying` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标的交易代码 (仅对杠杆ETP交易对有效)',
  `mgmt_fee_rate` decimal(20, 7) NULL DEFAULT NULL COMMENT '持仓管理费费率 (仅对杠杆ETP交易对有效)',
  `charge_time` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '持仓管理费收取时间 (24小时制，GMT+8，格式：HH:MM:SS，仅对杠杆ETP交易对有效)',
  `rebal_time` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '每日调仓时间 (24小时制，GMT+8，格式：HH:MM:SS，仅对杠杆ETP交易对有效)',
  `rebal_threshold` decimal(20, 7) NULL DEFAULT NULL COMMENT '临时调仓阈值 (以实际杠杆率计，仅对杠杆ETP交易对有效)',
  `init_nav` decimal(20, 7) NULL DEFAULT NULL COMMENT '初始净值（仅对杠杆ETP交易对有效）',
  `api_trading` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'API交易使能标记（有效值：enabled, disabled）',
  PRIMARY KEY (`unq_key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '交易对信息' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
