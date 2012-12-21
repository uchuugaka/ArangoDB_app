////////////////////////////////////////////////////////////////////////////////
/// @brief ArangoDB application delegate
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

#import "ArangoAppDelegate.h"

#import "ArangoToolbarMenu.h"
#import "ArangoManager.h"
#import "ArangoIntroductionController.h"

// -----------------------------------------------------------------------------
// --SECTION--                                                 ArangoAppDelegate
// -----------------------------------------------------------------------------

@implementation ArangoAppDelegate

// -----------------------------------------------------------------------------
// --SECTION--                                                   private methods
// -----------------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////
/// @brief destructor
////////////////////////////////////////////////////////////////////////////////

- (void) configurationDidChange: (NSNotification*) notification {
  [_statusMenu updateMenu];
}

// -----------------------------------------------------------------------------
// --SECTION--                                                    public methods
// -----------------------------------------------------------------------------

////////////////////////////////////////////////////////////////////////////////
/// @brief destructor
////////////////////////////////////////////////////////////////////////////////

- (void) dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  
  [_statusItem release];
  [_statusMenu release];
  [_manager release];
  
  [super dealloc];
}

////////////////////////////////////////////////////////////////////////////////
/// @brief called after application has been launched
////////////////////////////////////////////////////////////////////////////////

- (void) applicationDidFinishLaunching: (NSNotification *) notification {
  
  // create the ArangoDB manager
  _manager = [[ArangoManager alloc] init];
  
  if (_manager == nil) {
    NSAlert* info = [[[NSAlert alloc] init] autorelease];
      
    [info setMessageText:@"ArangoDB application failed to start!"];
    [info setInformativeText:@"Cannot create or load the configuration. Please reinstall the application."];
    
    [info runModal];
    [[NSApplication sharedApplication] terminate:nil];
    
    return;
  }
  
  // check for changes in the configuration
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(configurationDidChange:)
                                               name:ArangoConfigurationDidChange
                                             object:_manager];

  // create the menu
  _statusMenu = [[ArangoToolbarMenu alloc] initWithArangoManager:_manager];
  [_statusItem setMenu: _statusMenu];
  [_statusMenu setAutoenablesItems: NO];

  // we will have missed the first notification
  [_statusMenu updateMenu];

  // without any configuration, display some help
  if (0 == _manager.configurations.count) {
    // will autorelease on close
    [[ArangoIntroductionController alloc] initWithArangoManager:_manager];
  }
  else {
    [_manager startupInstances];
  }
}

////////////////////////////////////////////////////////////////////////////////
/// @brief creates the status menu item with icon
////////////////////////////////////////////////////////////////////////////////

-(void) awakeFromNib {
  _statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength] retain];

  [_statusItem setImage: [NSImage imageNamed:@"IconColor"]];
  [_statusItem setHighlightMode:YES];
}

@end

// -----------------------------------------------------------------------------
// --SECTION--                                                       END-OF-FILE
// -----------------------------------------------------------------------------

// Local Variables:
// mode: outline-minor
// outline-regexp: "^\\(/// @brief\\|/// {@inheritDoc}\\|/// @addtogroup\\|/// @page\\|// --SECTION--\\|/// @\\}\\)"
// End: