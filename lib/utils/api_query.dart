/// This API queries helps to decide the info to be returned by the API.
/// Helps to reduce downloaded data size.
class ApiQuery {
  static const launch = {
    'options': {
      'pagination': false,
      'select': {
        'links.patch.large': 0,
        'links.reddit.launch': 0,
        'links.reddit.media': 0,
        'links.reddit.recovery': 0,
        'links.flickr.small': 0,
        'links.youtube_id': 0,
        'links.article': 0,
        'links.wikipedia': 0,
        'fairings.ships': 0,
        'tbd': 0,
        'net': 0,
        'static_fire_date_unix': 0,
        'auto_update': 0,
        'date_unix': 0,
        'date_local': 0,
        'ships': 0,
        'capsules': 0,
        'crew': 0,
      },
      'populate': [
        {
          'path': 'rocket',
          'select': {
            'name': 1,
          }
        },
        {
          'path': 'launchpad',
          'select': {
            'rockets': 0,
            'launches': 0,
            'timezone': 0,
          }
        },
        {
          'path': 'payloads',
          'select': {
            'type': 0,
            'launch': 0,
            'norad_ids': 0,
            'mass_lbs': 0,
            'longitude': 0,
            'semi_major_axis_km': 0,
            'eccentricity': 0,
            'lifespan_years': 0,
            'epoch': 0,
            'regime': 0,
            'mean_motion': 0,
            'raan': 0,
            'arg_of_pericenter': 0,
            'mean_anomaly': 0,
            'reference_system': 0,
            'dragon.mass_returned_lbs': 0,
            'dragon.mass_returned_kg': 0,
            'dragon.flight_time_sec': 0,
            'dragon.manifest': 0,
            'dragon.water_landing': 0,
            'dragon.land_landing': 0
          },
          'populate': {
            'path': 'dragon.capsule',
            'select': {
              'mass_returned_lbs': 0,
              'land_landings': 0,
            },
            'populate': {
              'path': 'launches',
              'select': {
                'name': 1,
                'flight_number': 1,
                'date_utc': 1,
              }
            }
          }
        },
        {
          'path': 'cores',
          'select': {
            'flight': 0,
          },
          'populate': [
            {
              'path': 'core',
              'populate': {
                'path': 'launches',
                'select': {
                  'name': 1,
                  'flight_number': 1,
                  'date_utc': 1,
                }
              }
            },
            {
              'path': 'landpad',
              'select': {
                'launches': 0,
              }
            }
          ]
        }
      ]
    }
  };

  static const dragonVehicle = {
    'options': {
      'pagination': false,
      'select': {
        'heat_shield': 0,
        'launch_payload_vol': 0,
        'return_payload_vol': 0,
        'pressurized_capsule': 0,
        'trunk': 0,
        'sidewall_angle_deg': 0,
        'orbit_duration_yr': 0,
        'dry_mass_lb': 0,
        'launch_payload_mass.lb': 0,
        'return_payload_mass.lb': 0,
        'height_w_trunk.feet': 0,
        'diameter.feet': 0,
        'thrusters.pods': 0,
        'thrusters.thrust.lbf': 0
      }
    }
  };

  static const roadsterVehicle = {
    'options': {
      'pagination': false,
      'select': {
        'name': 0,
        'launch_date_unix': 0,
        'launch_mass_lbs': 0,
        'norad_id': 0,
        'epoch_jd': 0,
        'semi_major_axis_au': 0,
        'eccentricity': 0,
        'speed_mph': 0,
        'earth_distance_mi': 0,
        'mars_distance_mi': 0,
        'periapsis_arg': 0
      }
    }
  };

  static const rocketVehicle = {
    'options': {
      'pagination': false,
      'select': {
        'height.feet': 0,
        'diameter.feet': 0,
        'mass.lb': 0,
        'first_stage.thrust_sea_level.lbf': 0,
        'first_stage.thrust_vacuum.lbf': 0,
        'first_stage.burn_time_sec': 0,
        'second_stage.thrust.lbf': 0,
        'second_stage.payloads.composite_fairing.height.feet': 0,
        'second_stage.payloads.composite_fairing.diameter.feet': 0,
        'second_stage.payloads.option_1': 0,
        'second_stage.burn_time_sec': 0,
        'engines.thrust_sea_level.lbf': 0,
        'engines.thrust_vacuum.lbf': 0,
        'engines.number': 0,
        'engines.layout': 0,
        'engines.engine_loss_max': 0,
        'payload_weights.lb': 0,
        'landing_legs': 0,
        'country': 0,
        'company': 0
      }
    }
  };

  static const shipVehicle = {
    'query': {
      'active': true,
    },
    'options': {
      'pagination': false,
      'select': {
        'legacy_id': 0,
        'mmsi': 0,
        'abs': 0,
        'class': 0,
        'mass_lbs': 0,
        'course_deg': 0,
        'last_ais_update': 0,
        'imo': 0,
        'active': 0
      },
      'populate': [
        {
          'path': 'launches',
          'select': {
            'flight_number': 1,
            'name': 1,
          }
        }
      ]
    }
  };
}
