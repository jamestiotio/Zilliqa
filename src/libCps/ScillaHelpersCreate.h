/*
 * Copyright (C) 2023 Zilliqa
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

#ifndef ZILLIQA_SRC_LIBCPS_SCILLAHELPERSCREATE_H_
#define ZILLIQA_SRC_LIBCPS_SCILLAHELPERSCREATE_H_

#include <json/json.h>

class TransactionReceipt;

namespace libCps {

struct ScillaArgs;

class ScillaHelpersCreate final {
 public:
  using Address = dev::h160;
  static bool ParseCreateContract(uint64_t &gasRemained,
                                  const std::string &runnerPrint,
                                  TransactionReceipt &receipt, bool is_library);

 private:
  /// convert the interpreter output into parsable json object for deployment
  static bool ParseCreateContractOutput(Json::Value &jsonOutput,
                                        const std::string &runnerPrint,
                                        TransactionReceipt &receipt);

  /// parse the output from interpreter for deployment
  static bool ParseCreateContractJsonOutput(const Json::Value &_json,
                                            uint64_t &gasRemained,
                                            TransactionReceipt &receipt,
                                            bool is_library);
};
}  // namespace libCps

#endif  // ZILLIQA_SRC_LIBCPS_SCILLAHELPERSCREATE_H_
