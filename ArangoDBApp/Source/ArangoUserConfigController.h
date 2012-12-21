////////////////////////////////////////////////////////////////////////////////
/// @brief user configuration controller
///
/// @file
///
/// DISCLAIMER
///
/// Copyright 2012 triAGENS GmbH, Cologne, Germany
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///     http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
/// Copyright holder is triAGENS GmbH, Cologne, Germany
///
/// @author Dr. Frank Celler
/// @author Michael Hackstein
/// @author Copyright 2012, triAGENS GmbH, Cologne, Germany
////////////////////////////////////////////////////////////////////////////////

#import "ArangoBaseController.h"

// -----------------------------------------------------------------------------
// --SECTION--                                        ArangoUserConfigController
// -----------------------------------------------------------------------------

@interface ArangoUserConfigController : ArangoBaseController

// -----------------------------------------------------------------------------
// --SECTION--                                                        properties
// -----------------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////
/// @brief button "start on login"
////////////////////////////////////////////////////////////////////////////////

@property (nonatomic, assign) IBOutlet NSButton *startOnLoginButton;

////////////////////////////////////////////////////////////////////////////////
/// @brief combo "run on startup" options
////////////////////////////////////////////////////////////////////////////////

@property (nonatomic, assign) IBOutlet NSComboBox *runOnStartupOptions;

// -----------------------------------------------------------------------------
// --SECTION--                                                    public methods
// -----------------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////
/// @brief default constructor
////////////////////////////////////////////////////////////////////////////////

- (id) initWithArangoManager: (ArangoManager*) delegate;

////////////////////////////////////////////////////////////////////////////////
/// @brief stores options
////////////////////////////////////////////////////////////////////////////////

- (IBAction) storeConfiguration: (id) sender;

////////////////////////////////////////////////////////////////////////////////
/// @brief aborts
////////////////////////////////////////////////////////////////////////////////

- (IBAction) abortConfiguration: (id) sender;

@end

// -----------------------------------------------------------------------------
// --SECTION--                                                       END-OF-FILE
// -----------------------------------------------------------------------------

// Local Variables:
// mode: outline-minor
// outline-regexp: "^\\(/// @brief\\|/// {@inheritDoc}\\|/// @addtogroup\\|/// @page\\|// --SECTION--\\|/// @\\}\\)"
// End: